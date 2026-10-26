document.addEventListener("DOMContentLoaded", () => {
  document.querySelectorAll("form[data-confirm]").forEach(form => {
    form.addEventListener("submit", event => {
      if (!window.confirm(form.dataset.confirm || "Are you sure?")) event.preventDefault();
    });
  });

  const typeSelect = document.getElementById("violation-type");
  const fineInput = document.getElementById("fine-amount");
  if (typeSelect && fineInput) {
    typeSelect.addEventListener("change", () => {
      const option = typeSelect.options[typeSelect.selectedIndex];
      if (option && option.dataset.fine) fineInput.value = option.dataset.fine;
    });
  }
});
