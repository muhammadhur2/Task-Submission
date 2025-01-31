const form = document.getElementById('visitorForm');
const visitorNameInput = document.getElementById('visitorName');
const visitorsTableBody = document.querySelector('#visitorsTable tbody');

window.addEventListener('DOMContentLoaded', fetchVisitors);

form.addEventListener('submit', async (e) => {
  e.preventDefault();
  const name = visitorNameInput.value.trim();

  if (!name) return;

  try {
    const response = await fetch('/api/visitors', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ name })
    });

    if (response.ok) {
      visitorNameInput.value = '';
      await fetchVisitors(); 
    } else {
      console.error('Error adding visitor');
    }
  } catch (error) {
    console.error('Error adding visitor:', error);
  }
});

async function fetchVisitors() {
  try {
    const response = await fetch('/api/visitors');
    if (!response.ok) {
      throw new Error('Failed to fetch visitors');
    }
    const visitors = await response.json();

    visitorsTableBody.innerHTML = '';

    visitors.forEach(visitor => {
      const row = document.createElement('tr');

      const idCell = document.createElement('td');
      const nameCell = document.createElement('td');
      const timeCell = document.createElement('td');

      idCell.textContent = visitor.id;
      nameCell.textContent = visitor.name;
      timeCell.textContent = new Date(visitor.visit_time).toLocaleString();

      row.appendChild(idCell);
      row.appendChild(nameCell);
      row.appendChild(timeCell);

      visitorsTableBody.appendChild(row);
    });
  } catch (error) {
    console.error('Error fetching visitors:', error);
  }
}
