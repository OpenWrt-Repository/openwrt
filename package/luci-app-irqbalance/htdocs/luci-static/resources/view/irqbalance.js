'use strict';
'require view';
'require fs';
'require form';
'require ui';
'require rpc';

const callServiceList = rpc.declare({
    object: 'service',
    method: 'list',
    params: ['name'],
    expect: { '': {} },
});

function getServiceStatus() {
    return L.resolveDefault(callServiceList('irqbalance'), {}).then(function (res) {
        try {
            return res['irqbalance']['instances']['irqbalance']['running'];
        } catch (e) {
            return false;
        }
    });
}

var cbiRichListValue = form.ListValue.extend({
	renderWidget: function(section_id, option_index, cfgvalue) {
		var choices = this.transformChoices();
		var widget = new ui.Dropdown((cfgvalue != null) ? cfgvalue : this.default, choices, {
			id: this.cbid(section_id),
			sort: this.keylist,
			optional: true,
			multiple: true,
			display_items: 5,
			dropdown_items: 10,
			select_placeholder: this.select_placeholder || this.placeholder,
			custom_placeholder: this.custom_placeholder || this.placeholder,
			validate: L.bind(this.validate, this, section_id),
			disabled: (this.readonly != null) ? this.readonly : this.map.readonly
		});
		return widget.render();
	},

	value: function(value, title, description) {
		if (description) {
			form.ListValue.prototype.value.call(this, value, E([], [
				E('span', { 'class': 'hide-open' }, [ title ]),
				E('div', { 'class': 'hide-close', 'style': 'min-width:25vw' }, [
					E('strong', [ title ]),
					E('br'),
					E('span', { 'style': 'white-space:normal' }, description)
				])
			]));
		}
		else {
			form.ListValue.prototype.value.call(this, value, title);
		}
	}
});

var CBISelectswitch = form.DummyValue.extend({                                                                                         
    renderWidget: function(section_id, option_id, cfgvalue) {                                                                          
        var section = this.section;                                                                                                    
        return E([], [                                                                                                                 
            E('span', { 'class': 'control-group' }, [                                                                                  
                E('button', {                                                                                                          
                    'class': 'cbi-button cbi-button-apply',                                                                            
                    'click': ui.createHandlerFn(this, function() {                                                                     
                        var dropdown = section.getUIElement(section_id, 'banirq');                                              
                        dropdown.setValue([]);                                                                                         
                    }),                                                                                                                
                }, _('Deselect all')),                                                                                                 
                ' ',                                                                                                                   
                E('button', {                                                                                                          
                    'class': 'cbi-button cbi-button-action important',                                                                 
                    'click': ui.createHandlerFn(this, function() {                                                                     
                        var dropdown = section.getUIElement(section_id, 'banirq');                                              
                        dropdown.setValue(Object.keys(dropdown.choices));                                                              
                    })                                                                                                                 
                }, _('Select all'))                                                                                                    
            ])                                                                                                                         
        ]);                                                                                                                            
    },                                                                                                                                 
});

function renderStatus(isRunning) {
    const spanTemp = '<span style="color:%s"><strong>%s</strong></span>';

    return isRunning
        ? String.format(spanTemp, 'green', _('RUNNING'))
        : String.format(spanTemp, 'red', _('NOT RUNNING'));
}

function handleAction(ev) {
	if (ev === 'test') {
	return uci.load('irqbalance').then(function() {
	var sections = uci.sections('irqbalance');

	var rule_enabled = [];

	for (let i=0; i<sections.length; i++) {
		rule_enabled.push(sections[i].banirq)
	}
	var ax = rule_enabled.toString();
	ui.addNotification(null, E('p', _('All rules are disabled!')+ax), 'error');
    	});
	}
}

return view.extend({
    load() {
        return L.resolveDefault(fs.read_direct('/proc/interrupts'));
    },

    render(data) {
	const cpuNum = data.match(/\bCPU\d+\b/g).map(i => i.slice(3)), // cpuNum = data.match(/(?<=\bCPU)\d+\b/g), // Safari did not support RegExp lookbehind assertion before version 16.4.
		irqNum = data.match(/\b\d+(?=: )/g),
		irqNameMatches = data.match(/(?<=\d+:)\s*(\S.*)/g);

	const irqName = irqNameMatches ? irqNameMatches.map(match => match.trim()) : [];

        let m, s, o;

        m = new form.Map('irqbalance', _('irqbalance'), _('The purpose of irqbalance is to distribute hardware interrupts across processors/cores on a multiprocessor/multicore system in order to increase performance.'));

        s = m.section(form.NamedSection);
        s.anonymous = true;
        s.render = function () {
            L.Poll.add(function () {
                return L.resolveDefault(getServiceStatus()).then(function (res) {
                    const view = document.getElementById('status');
                    view.innerHTML = renderStatus(res);
                });
            });

            return E('div', { class: 'cbi-section' }, [
                E('p', { id: 'status' }, _('Loading...'))
            ]);
        }

        s = m.section(form.TypedSection, 'irqbalance', _('Snapshot of current IRQs'));
        s.anonymous = true;

        s = m.section(form.NamedSection);
        s.anonymous = true;
        s.render = function () {
            const snapshot = new ui.Textarea(data.slice(0, -1), {
                readonly: true,
                placeholder: _('Loading...'),
                monospace: true,
                rows: data.split('\n').length - 1,
            });
            return snapshot.render();
        }

        s = m.section(form.TypedSection, 'irqbalance', _('General settings'));
        s.anonymous = true;

        o = s.option(form.Flag, 'enabled', _('Enable'));
        o.default = '0';
        o.rmempty = false;

        o = s.option(form.Value, 'deepestcache', _('Deepest cache'), _('Cache level at which irqbalance partitions cache domains.'));
        o.placeholder = '2';
        o.datatype = 'uinteger';
        o.optional = true;

        o = s.option(form.Value, 'interval', _('Interval'), _('Value in seconds.'));
        o.placeholder = '10';
        o.datatype = 'uinteger';
        o.optional = true;

        o = s.option(form.Value, 'banned_cpulist', _('Exclude CPUs'), _('List of CPUs to ignore, can be an integer or integers separated by commas.') + '<br />' + _('Valid values: %s.').format(cpuNum.join(', ')));
        o.placeholder = '0';
        o.optional = true;
        o.validate = function (section_id, value) {
            for (const i of value.split(',')) {
                if (!cpuNum.includes(i) && i != '') {
                    return _('Invalid');
                }
            }
            return true;
        }

	o = s.option(cbiRichListValue, 'banirq', _('Exclude IRQs'), _('List of IRQs to ignore.') + '<br />' + _('Valid values: %s.').format(irqNum.join(', ')));

	for (let i = 0; i < irqNum.length; i++) 
	{
              o.value(irqNum[i], irqNum[i], irqName[i].match(/\S+$/));
	}
		
	o.multiple = true;
	o.placeholder = _('Select IRQs to ignore');

	o = s.option(CBISelectswitch, '_switch', _('IRQs selection switch'));

        return m.render();
    }
});
