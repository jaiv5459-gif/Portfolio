// Developer: Jai Verma

const API_URL = 'http://localhost/project_oceanus/backend/api.php';

document.addEventListener('DOMContentLoaded', () => {
    fetchFleet();

    const form = document.getElementById('fleet-form');
    form.addEventListener('submit', async (e) => {
        e.preventDefault();
        
        const shipData = {
            ship_name: document.getElementById('ship_name').value,
            ship_class: document.getElementById('ship_class').value
        };

        try {
            const response = await fetch(API_URL, {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify(shipData)
            });

            if (response.ok) {
                form.reset();
                fetchFleet(); // Reload the table
            } else {
                console.error("Failed to deploy ship.");
            }
        } catch (error) {
            console.error("Error connecting to server:", error);
        }
    });
});

async function fetchFleet() {
    try {
        const response = await fetch(API_URL);
        const ships = await response.json();
        
        const tbody = document.getElementById('fleet-data');
        tbody.innerHTML = '';

        ships.forEach(ship => {
            const tr = document.createElement('tr');
            tr.innerHTML = `
                <td>#${ship.id}</td>
                <td><strong>${ship.ship_name}</strong></td>
                <td>${ship.ship_class}</td>
                <td><span class="status-badge">${ship.operational_status}</span></td>
            `;
            tbody.appendChild(tr);
        });
    } catch (error) {
        console.error("Error fetching fleet data:", error);
    }
}