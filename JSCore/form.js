var form;

function addContact(){
  var name = form.name.value;
  var company = form.company.value;
  var phone = form.phone.value;
  var contact = Contact.contactWithNameCompanyPhone(name, company, phone);
  
  if (!contactManager.addContact(contact)) {
    alert('Failed to add contact, please verify the form.');
    return false;
  }
  
  history.back();
}

var leftBarButtonItem = {
  'title' : 'Cancel',
  'callback' : function(){
    history.back();
  }
};

var rightBarButtonItem = {
  'title' : 'Save',
  'callback' : function(){
    addContact();
  }
};

function pageDidLoad() {
  form = document.getElementById('main-form');
}