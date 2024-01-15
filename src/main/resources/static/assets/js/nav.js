
document.querySelector('#nMemberResListBtn').addEventListener('click', function () {
    if(sessionStorage.getItem('phnm') === null){
		Swal.fire({
	        title: '전화번호 인증',
	        text: '비회원 예매조회를 위해서는 인증이 필요합니다.',
	
	        input: 'text',
	        inputAttributes: {
	            autocapitalize: 'off'
	        },
	        inputPlaceholder: '01012345678',
	        showCancelButton: true,
	        confirmButtonText: '인증받기',
	        cancelButtonText: '취소', // cancel 버튼 텍스트 지정
	
	        showLoaderOnConfirm: true, // 데이터 결과를 받을때까지, 버튼에다가 로딩바를 표현
	        preConfirm: (login) => { // 확인 버튼 누르면 실행되는 콜백함수
	            return fetch('/routeinfotest')
	            .then(response => {
	                if (!response.ok) {
	                throw new Error(response.statusText)
	                }
	                const encodedPhoneNum = encodeURIComponent(login);
	                //window.location.href = `/reservation/nmemberlist?phoneNum=${encodedPhoneNum}`
	                //성공하면 추가로직 여기아래에
				    sessionStorage.setItem('phnm', encodedPhoneNum);
					return (async () => {
					    const { value: getName } = await Swal.fire({
					        title: '인증번호를 입력하세요.',
					        //text: '그냥 예시일 뿐입니다.',
					        input: 'text',
					        inputPlaceholder: '인증번호'
					    })
					    // 이후 처리되는 내용.
					    if (getName) {
					        //Swal.fire(`: ${getName}`)
					        
					        window.location.href = `/reservation/nmemberlist?phoneNum=${encodedPhoneNum}`
					    }
					})()
	
	                //return response.json()
	            })
	            .catch(error => {
	                Swal.showValidationMessage(
	                `Request failed: ${error}`
	                )
	            })
	        },
	        
	        // 실행되는 동안 배경 누를때 모달창 안닫히도록 설정
	        // isLoading() 즉, 로딩이 진행되는 동안 false를 리턴하게 해서 ousideClick을 안되게 하고, 로딩 상태가 아니면 ousideClick을 허용한다.
	        allowOutsideClick: () => !Swal.isLoading() 
	        
	        }).then((result) => {
	
	        if (result.isConfirmed) {
	            Swal.fire({
	            title: `${result.value.login}'s avatar`,
	            imageUrl: result.value.avatar_url
	            })
	        }
        })
	}else{
		var phoneNm = sessionStorage.getItem('phnm');
		window.location.href = `/reservation/nmemberlist?phoneNum=${phoneNm}`
	}

})
