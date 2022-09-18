function submitOnChange() {
  document.getElementById('any_login_form').submit();
}

function elementExists(element) {
  return typeof (element) != 'undefined' && element != null;
}

function addChangeListenerTo(elementId) {
  let element = document.getElementById(elementId);
  if (elementExists(element)) {
    element.addEventListener("change", submitOnChange);
  }
}

function setupAnyLoginHandlers() {
  addChangeListenerTo("back_to_previous_id");
  addChangeListenerTo("selected_id");
}

['DOMContentLoaded', 'turbolinks:load', 'turbo:load'].forEach(function(e) {
  // window.addEventListener(e, setupAnyLoginHandlers);
  const forms = document.querySelectorAll('.any_login_form');
  forms.forEach(form => {
    const selects = form.querySelectorAll('select');
    selects.forEach(select => {
      select.addEventListener('change', () => {
        form.submit();
      })
    })
  })
});
