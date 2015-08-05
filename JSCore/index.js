var rightBarButtonItem = {
  'title' : '+',
  'callback' : function(){
    window.location = 'form.html';
  }
};

function contactName(contact) {
  var span = document.createElement('span');
  span.innerHTML = contact.name;
  span.className = 'name';
  return span;
}

function companyName(contact) {
  var span = document.createElement('span');
  span.innerHTML = contact.name;
  span.className = 'company';
  return span;
}

function callLink(contact) {
    var link = document.createElement('a');
    link.href = 'javascript:void(0)';
    link.innerHTML = 'Call ' + contact.phone;
    link.className = 'call';
    link.onclick = function(){
      if (confirm('Do you really want to call '+contact.phone+'?')){
        callNumber(contact.phone);
      }
    }
    
    return link;
}

function deleteLink(contact) {
  var link = document.createElement('a');
  link.href = 'javascript:void(0)';
  link.innerHTML = '[x] Delete';
  link.className = 'delete';
  link.onclick = function(){
    if(confirm('Do you want to delete the contact "' + contact.name +  '"?')) {
      contactManager.deleteContact(contact);
      reloadItems();
    }
  }
  return link;
}

function listItem(contact) {
  var item = document.createElement('li');
  item.appendChild(deleteLink(contact));
  item.appendChild(contactName(contact));
  item.appendChild(callLink(contact));
  item.appendChild(companyName(contact));
  return item;
}

function reloadItems() {
  var list = document.getElementById('list');
  list.innerHTML = '';
  for (n in contactManager.contacts) {
    var contact = contactManager.contacts[n];
    list.appendChild(listItem(contact));
  }
}

function pageDidLoad() {
  reloadItems();
}