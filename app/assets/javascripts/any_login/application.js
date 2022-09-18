function setupAnyLoginHandlers() {
  const forms = document.querySelectorAll('.any_login_form');
  forms.forEach(form => {
    const selects = form.querySelectorAll('select');
    selects.forEach(select => {
      select.addEventListener('change', () => {
        form.submit();
      })
    })
  })
}

['DOMContentLoaded', 'turbolinks:load', 'turbo:load'].forEach(function(e) {
  window.addEventListener(e, setupAnyLoginHandlers);
});
