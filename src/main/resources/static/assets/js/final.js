
//var esc = $.Event("keydown", { keyCode: 27 });
//$("body").trigger(esc); // change body to the element where you'd like to execute the escape key press.

//============================ 출발지 검색 =========================
// Function to send GET request and update table
function updateTerminalTable1(searchTerm) {
	// Send GET request to /search-terminal with the searchTerm
	fetch(`/search-terminal?terminalName=${encodeURIComponent(searchTerm)}`, {
		method: 'GET',
		headers: {
			'Content-Type': 'application/json',
			// You can add additional headers if needed
		},
	})
		.then(response => response.json())
		.then(data => {
			// Get the table body element
			const tableBody = document.getElementById('terminalTable1').getElementsByTagName('tbody')[0];

			// Clear existing table rows
			tableBody.innerHTML = '';

			// Add new rows based on the returned data
			data.forEach(terminal => {
				const row = tableBody.insertRow();
				const cell = row.insertCell(0);
				cell.textContent = terminal;
			});
		})
		.catch(error => {
			console.error('Error fetching terminal data:', error);
		});
}

// Add event listener for input changes
document.getElementById('TerminalSearchInput1').addEventListener('input', function() {
	const searchTerm = this.value.trim();
	const dropdownTable = document.getElementById('terminalTable1');

	// Check if the search term is not empty
	if (searchTerm !== '') {
		// 창을 보이게 설정
		dropdownTable.classList.add('show');

		// Call the function to update table data
		updateTerminalTable1(searchTerm);
	} else {
		// 창을 안 보이게 설정
		dropdownTable.classList.delete('show');

		// If the search term is empty, clear the table rows
		document.getElementById('terminalTable1').getElementsByTagName('tbody')[0].innerHTML = '';
	}
});

// Add event listener to close dropdown when clicking outside
document.addEventListener('click', function(event) {
	const dropdownMenu = document.getElementById('dropdownMenuButton1');
	const terminalTable = document.getElementById('terminalTable1');

	// Check if the clicked element is not within the dropdown or the terminalTable
	if (!dropdownMenu.contains(event.target) && !terminalTable.contains(event.target)) {
		// 선택하면, 리스트 지우기
		document.getElementById('terminalTable1').getElementsByTagName('tbody')[0].innerHTML = '';
		// Trigger 'Escape' key press
		const escapeKeyEvent = new KeyboardEvent('keydown', {
			key: 'Escape',
			keyCode: 27,
		});
		document.dispatchEvent(escapeKeyEvent);
		dropdownMenu.classList.remove('show');
	}
});

// Add event listener for table row clicks
document.getElementById('terminalTable1').addEventListener('click', function(event) {
	const clickedRow = event.target.closest('td');

	// Check if the clicked element is an anchor tag within the table
	if (clickedRow) {
		// Set input's value to the clicked row's value
		document.getElementById('TerminalSearchInput1').value = clickedRow.textContent.trim();

		// 선택하면, 리스트 지우기
		document.getElementById('terminalTable1').getElementsByTagName('tbody')[0].innerHTML = '';

		// Trigger 'Escape' key press
		const escapeKeyEvent = new KeyboardEvent('keydown', {
			key: 'Escape',
			keyCode: 27,
		});
		document.dispatchEvent(escapeKeyEvent);

		// Hide the dropdown menu
		document.getElementById('dropdownMenuButton1').classList.remove('show');
	}
});

//======================= 도착지 검색 =========================
// Function to send GET request and update table
function updateTerminalTable2(searchTerm) {
	// Send GET request to /search-terminal with the searchTerm
	fetch(`/search-terminal?terminalName=${encodeURIComponent(searchTerm)}`, {
		method: 'GET',
		headers: {
			'Content-Type': 'application/json',
			// You can add additional headers if needed
		},
	})
		.then(response => response.json())
		.then(data => {
			// Get the table body element
			const tableBody = document.getElementById('terminalTable2').getElementsByTagName('tbody')[0];

			// Clear existing table rows
			tableBody.innerHTML = '';

			// Add new rows based on the returned data
			data.forEach(terminal => {
				const row = tableBody.insertRow();
				const cell = row.insertCell(0);
				cell.textContent = terminal;
			});
		})
		.catch(error => {
			console.error('Error fetching terminal data:', error);
		});
}

// Add event listener for input changes
document.getElementById('TerminalSearchInput2').addEventListener('input', function() {
	const searchTerm = this.value.trim();
	const dropdownTable = document.getElementById('terminalTable2');

	// Check if the search term is not empty
	if (searchTerm !== '') {
		// 창을 보이게 설정
		dropdownTable.classList.add('show');

		// Call the function to update table data
		updateTerminalTable2(searchTerm);
	} else {
		// 창을 안 보이게 설정
		dropdownTable.classList.delete('show');

		// If the search term is empty, clear the table rows
		document.getElementById('terminalTable2').getElementsByTagName('tbody')[0].innerHTML = '';
	}
});

// Add event listener to close dropdown when clicking outside
document.addEventListener('click', function(event) {
	const dropdownMenu = document.getElementById('dropdownMenuButton2');
	const terminalTable = document.getElementById('terminalTable2');

	// Check if the clicked element is not within the dropdown or the terminalTable
	if (!dropdownMenu.contains(event.target) && !terminalTable.contains(event.target)) {
		// 선택하면, 리스트 지우기
		document.getElementById('terminalTable2').getElementsByTagName('tbody')[0].innerHTML = '';
		// Trigger 'Escape' key press
		const escapeKeyEvent = new KeyboardEvent('keydown', {
			key: 'Escape',
			keyCode: 27,
		});
		document.dispatchEvent(escapeKeyEvent);
		dropdownMenu.classList.remove('show');
	}
});

// Add event listener for table row clicks
document.getElementById('terminalTable2').addEventListener('click', function(event) {
	const clickedRow = event.target.closest('td');

	// Check if the clicked element is an anchor tag within the table
	if (clickedRow) {
		// Set input's value to the clicked row's value
		document.getElementById('TerminalSearchInput2').value = clickedRow.textContent.trim();

		// 선택하면, 리스트 지우기
		document.getElementById('terminalTable2').getElementsByTagName('tbody')[0].innerHTML = '';

		// Trigger 'Escape' key press
		const escapeKeyEvent = new KeyboardEvent('keydown', {
			key: 'Escape',
			keyCode: 27,
		});
		document.dispatchEvent(escapeKeyEvent);

		// Hide the dropdown menu
		document.getElementById('dropdownMenuButton2').classList.remove('show');
	}
});




