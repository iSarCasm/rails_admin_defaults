// Defaults getter
$(document).ready(function() {
  jQuery.expr[':'].regex = function(elem, index, match) {
      var matchParams = match[3].split(','),
          validLabels = /^(data|css):/,
          attr = {
              method: matchParams[0].match(validLabels) ?
                          matchParams[0].split(':')[0] : 'attr',
              property: matchParams.shift().replace(validLabels,'')
          },
          regexFlags = 'ig',
          regex = new RegExp(matchParams.join('').replace(/^\s+|\s+$/g,''), regexFlags);
      return regex.test(jQuery(elem)[attr.method](attr.property));
  }

  $(document).on('change', '[data-has-defaults]', function(val) {
    defs = $(this).val();
    s = $('[data-has-defaults]').first()[0].name.split('[')
    to = s[0]
    from = s[1].slice(0, -4) // _id]
    if (defs) {
      get_defaults(from, defs, to)
    }
  });

  function get_defaults(model, id, current) {
    $.get("/admin/"+model+"/"+id+"/defaults.json", function(data, status){
      // console.log(data)
      $.each(data, function(key, value) {
        name = key
        data = value.data
        title = value.title
        type = define_type(data)
        console.log(type)
        if(type === 'object') {
          populate_select_with_default(current + '_' + name + '_id', {id: data.id, text: title})
        } else if(type === 'array') {
          populate_association_with_defaults(current, name, data)
        } else if(type === 'string') {
          elem = $('#'+current+'_'+name).first()
          populate_string(elem, data)
        } else if(type === 'null') {
          populate_select_with_default(current + '_' + name + '_id', {id: '', text: ''})
          clear_association(name);
          elem = $('#'+current+'_'+name).first()
          populate_string(elem, '')
          populate_string(elem, false)
        }
      })
    });
  }

  function define_type( val) {
    if(Array.isArray(val)) {
      return 'array';
    } else if(val === null) {
      return 'null'
    } else if (typeof(val) === 'object') {
      return 'object';
    } else {
      return 'string';
    }
  }

  function populate_select_with_default(target, value) {
    // console.log(target)
    $('#'+target).first().empty();
    option = '<option value="' + value.id + '" selected="selected">' + value.text + '</option>'
    $('#tour_hotel_board_basis_id').first().append(option)
    $('[data-input-for="' + target +'"]').first().find('input').first().val(value.text)
  }

  function populate_association_with_defaults(from, name, data) {
    clear_association(name);
    for(var i = 0; i < data.length; i++) {
      value = data[i]
      // add new field
      $('.add_nested_fields[data-association="' + name  +'"]').first().click()
      $.each(value, function(key, val) {
        type = define_type(val)
        elem = $(':regex(id, '+from+'_'+name+'_attributes.+' + key + '$)').last();
        // console.log(key)
        // console.log('tour_hotel_'+name+'_attributes.+' + key)
        // console.log(elem)
        if (elem[0]) {
          if (type === 'object') {
            target = elem[0].id
            populate_select_with_default(target, {id: val.data.id, text: val.title})
          } else if(type === 'string') {
            populate_string(elem, val)
          }
        }
      });
    }
  }

  function clear_association(name) {
    $('.remove_nested_fields[data-association="' + name + '"').click()
  }

  function populate_string(elem, val) {
    console.log(val)
    if (val === true) {
      elem.prop('checked', true)
    } else if(val === false) {
      elem.prop('checked', false)
    } else {
      elem.val(val);
    }
  }
});
