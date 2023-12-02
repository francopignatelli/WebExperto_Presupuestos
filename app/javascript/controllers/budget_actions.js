document.addEventListener('DOMContentLoaded', function() {
document.getElementById('quit-budget-btn').addEventListener('click', function(event) {
    event.preventDefault();
    if (confirm("¿Estás seguro de que quieres eliminar este presupuesto?")) {
    fetch(this.href, {
        method: 'DELETE',
        headers: {
        'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').content
        }
    }).then(function(response) {
        window.location.href = "<%= budgets_path %>";
    }).catch(function(error) {
        console.error('Error:', error);
    });
    }
});
});