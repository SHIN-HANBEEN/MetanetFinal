
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

			console.log(data);

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
		dropdownTable.classList.remove('show');

		// If the search term is empty, clear the table rows
		document.getElementById('terminalTable1').getElementsByTagName('tbody')[0].innerHTML = '';
	}
});

// Add event listener to close dropdown when clicking outside
document.addEventListener('click', function(event) {
	const dropdownMenu = document.getElementById('TerminalSearchInput1');
	const terminalTable = document.getElementById('terminalTable1');
	const dropdownTable = document.getElementById('terminalTable1');

	// Check if the clicked element is not within the dropdown or the terminalTable
	if (!dropdownMenu.contains(event.target) && !terminalTable.contains(event.target)) {
		dropdownTable.classList.remove('show');
		document.getElementById('terminalTable1').getElementsByTagName('tbody')[0].innerHTML = '';
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
		dropdownTable.classList.remove('show');

		// If the search term is empty, clear the table rows
		document.getElementById('terminalTable2').getElementsByTagName('tbody')[0].innerHTML = '';
	}
});

// Add event listener to close dropdown when clicking outside
document.addEventListener('click', function(event) {
	const dropdownMenu = document.getElementById('TerminalSearchInput2');
	const terminalTable = document.getElementById('terminalTable2');
	const dropdownTable = document.getElementById('terminalTable2');

	// Check if the clicked element is not within the dropdown or the terminalTable
	if (!dropdownMenu.contains(event.target) && !terminalTable.contains(event.target)) {
		dropdownTable.classList.remove('show');
		document.getElementById('terminalTable2').getElementsByTagName('tbody')[0].innerHTML = '';
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

// 검색 버튼에 이벤트 리스너 설정 해주기
document.getElementById('submitButton1').addEventListener('click', async function() {
	const dpTerminalName = document.getElementById('TerminalSearchInput1').value.trim();
	const arrTerminalName = document.getElementById('TerminalSearchInput2').value.trim();
	const dpDate = document.getElementById('dpDate').value.trim();

	const scheduleDiv = document.getElementById('scheduleDiv');

	// Check if the search term is not empty
	if (dpTerminalName !== '' && arrTerminalName !== '' && dpDate !== '') {
		// 창을 보이게 설정
		scheduleDiv.classList.remove('metanet-hidden');

		try {
			// Call the function to update table data
			const data = await getSchedule(dpTerminalName, arrTerminalName, dpDate);
			console.log(data);
		} catch (error) {
			console.error('Error fetching schedule data:', error);
		}
	} else {
		// 창을 안 보이게 설정
		scheduleDiv.classList.add('metanet-hidden');

		// If the search term is empty, clear the table rows
		document.getElementById('scheduleTable1').getElementsByTagName('tbody')[0].innerHTML = '';
	}
});



// ============== 시간표 조회 ===============
function getSevenDaysAgo(dateString) {
	// Parse the input date string to create a Date object
	const inputDate = new Date(dateString);

	// Calculate the date 7 days ago
	const sevenDaysAgo = new Date(inputDate);
	sevenDaysAgo.setDate(sevenDaysAgo.getDate() - 7);

	// Format the result as 'YYYY-MM-DD'
	const formattedResult = sevenDaysAgo.toISOString().slice(0, 10);

	return formattedResult;
}

// Function to send GET request and update table
async function getSchedule(dpTerminalName, arrTerminalName, dpDate) {
	console.log("[[AOP Before]] - getSevenDaysAgo");
	const resultDateString = getSevenDaysAgo(dpDate);

	try {
		// Send GET request to /search-schedule with the searchTerm
		const response = await fetch(
			`/search-schedule?dpTerminalName=${dpTerminalName}
      &arrTerminalName=${arrTerminalName}
      &dpDate=${resultDateString}`,
			{
				headers: {
					"Access-Control-Allow-Origin": "*", // Required for CORS support to work
					"Access-Control-Allow-Credentials": true // Required for cookies, authorization headers with HTTPS
				}
			}
		);

		console.log(response);

		if (!response.ok) {
			throw new Error('Network response was not ok');
		}

		const data = await response.json();

		console.log(data);

		// Get the table body element
		const tableBody = document.getElementById('scheduleTable1').getElementsByTagName('tbody')[0];

		// Clear existing table rows
		tableBody.innerHTML = '';

		// Add new rows based on the returned data
		data.response.body.items.item.forEach(async schedule => {
			const row = tableBody.insertRow();

			// Populate table cells with schedule data
			const depPlaceCell = row.insertCell(0);
			let depPlaceNm = schedule.depPlaceNm;
			depPlaceCell.textContent = depPlaceNm;

			const depTimeCell = row.insertCell(1);
			let depPlandTime = schedule.depPlandTime;
			depTimeCell.textContent = depPlandTime;

			const arrPlaceCell = row.insertCell(2);
			let arrPlaceNm = schedule.arrPlaceNm;
			arrPlaceCell.textContent = arrPlaceNm;

			const arrTimeCell = row.insertCell(3);
			let arrPlandTime = schedule.arrPlandTime;
			arrTimeCell.textContent = arrPlandTime;

			const chargeCell = row.insertCell(4);
			let charge = schedule.charge;
			chargeCell.textContent = charge;

			const gradeCell = row.insertCell(5);
			let gradeNm = schedule.gradeNm
			gradeCell.textContent = gradeNm;

			const remainingSeats = row.insertCell(6);
			console.log("[[AOP Before]] - getRemainingSeats");

			// 문제였던 부분
			try {
				const remainingSeatsValue = await getRemainingSeats(depPlaceNm, arrPlaceNm,
					depPlandTime, arrPlandTime, gradeNm, charge);

				console.log("잔여좌석 뿌리기 전 최종 값 : " + remainingSeatsValue);

				remainingSeats.textContent = remainingSeatsValue;
			} catch (error) {
				console.error('Error fetching remaining seats:', error);
			}

			const reservationCell = row.insertCell(7);
			// Create the Info button with a link that includes parameters
			const infoButton = document.createElement("button");
			infoButton.type = "button";
			infoButton.className = "btn bg-gradient-info my-2";
			infoButton.textContent = "Info";

			// Attach a click event listener to handle the button click
			infoButton.addEventListener("click", async () => {
				try {
					// Include the parameters in the URL
					const url = `/reservation/seats-selection?dpTerminalName=${encodeURIComponent(depPlaceNm)}&arrTerminalName=${encodeURIComponent(arrPlaceNm)}&departureTime=${encodeURIComponent(depPlandTime)}`;

					// Redirect to the URL
					window.location.href = url;
				} catch (error) {
					console.error('Error handling Info button click:', error);
				}
			});

			// Append the button to the reservationCell
			reservationCell.appendChild(infoButton);
		});
	} catch (error) {
		console.error('Error fetching terminal data:', error);
	}
}

// getRemainingSeats => get-remaining-seats 로 Get 요청 보내기
async function getRemainingSeats(depPlaceNm, arrPlaceNm, depPlandTime, arrPlandTime,
	gradeNm, charge) {
	try {
		let result;
		await fetch(
			`/get-remaining-seats?depPlaceNm=${depPlaceNm}
      				&arrPlaceNm=${arrPlaceNm}
      				&depPlandTime=${depPlandTime}
      				&arrPlandTime=${arrPlandTime}
      				&gradeNm=${gradeNm}
      				&charge=${charge}`
		).then(
			(response) => response.text()
		).then(
			(data) => {
				result = data;
			}
		);
		console.log("result 결과 : " + result);
		return result;
	} catch (error) {
		console.error('Error fetching data:', error);
	}
}


// jquery 
// 모달 창 관련 JS 코드들
// Function to handle button click
function onButtonClick(cityName) {
	// Make AJAX request
	$.ajax({
		url: '/terminal-list',
		type: 'GET',
		data: { cityName: cityName },
		success: function(data) {
			// Update the table body with the returned data
			updateTableBody(data);
		},
		error: function(error) {
			console.error('Error fetching terminal list:', error);
		}
	});
}

// Function to update table body with the returned data
function updateTableBody(data) {
	// Get the tbody element
	var tbody = $('table tbody');

	// Clear existing data
	tbody.empty();

	// Iterate through the data and append rows to the tbody
	for (var i = 0; i < data.length; i++) {
		var row = '<tr><td>' + data[i] + '</td></tr>';
		tbody.append(row);
	}
}

// Attach click event handlers to buttons
$(document).ready(function() {
	$('.metanet-width-96px').click(function() {
		// Get the text value of the clicked button
		var cityName = $(this).text().trim();
		onButtonClick(cityName);
	});
});

// Function to handle row click and insert data into input
function onRowClick(cityName, inputId) {
	// Get the input element by ID
	var inputElement = $('#' + inputId);

	// Insert the clicked data into the input
	inputElement.val(cityName);

	// Close the modal if needed (assuming your modal has an ID of 'exampleModal')
	$('#exampleModal').modal('hide');
}

// Function to handle hover effect on table rows
function onRowHover(row) {
	row.addClass('table-primary'); // Add a hover effect using Bootstrap's 'table-primary' class
}

// Function to handle mouse leave on table rows
function onRowLeave(row) {
	row.removeClass('table-primary'); // Remove the hover effect
}

// Attach click event handlers to table rows
$(document).ready(function() {
	// For Terminal Table 1
	$('#exampleModal1').on('click', 'tr', function() {
		// Get the text value of the clicked row
		var cityName = $(this).text().trim();

		// Call the function to insert data into the input field
		onRowClick(cityName, 'TerminalSearchInput1');
	});

	// For Terminal Table 2
	$('#exampleModal2').on('click', 'tr', function() {
		// Get the text value of the clicked row
		var cityName = $(this).text().trim();

		// Call the function to insert data into the input field
		onRowClick(cityName, 'TerminalSearchInput2');
	});
});





