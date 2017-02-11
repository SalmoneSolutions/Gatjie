var searchStr =''
var letterCount = 0;
$('#dropdown1').css('width','500px')
$('#serching').css('overflow','hidden')
$('input').keyup(function(key){
		$('#dropdown1').css({width: '418px',position: 'absolute',top: '135.266px',left: '200.734px', opacity: '1', display: 'block'})
		if(key.which == 8 ){
			letterCount--;
			searchStr = searchStr.slice(0,searchStr.length-1)
		}
		else{
			letterCount++;
			searchStr+=String.fromCharCode(key.which)

		}


		console.log(searchStr)
		if(searchStr!='' && letterCount >= 3 ){
			$.post('/search',{find:searchStr.toLowerCase()},function(data){

				var html =''
				data.forEach(function(result){
						html += "<form id='location' action='/location/searched' method='post'>"+
									"<input style='display:none' name='latitude' id='latitude' value="+result.latitude+">"+
									"<input style='display:none' name='longitude' id='longitude' value="+result.longitude+">"+
									"<button type='submit' class='btn-flat white black-text col s12 m12'>"+result.name+"</button>"+
								"</form>";

				})
				$('#dropdown1').html(html)
		})
	}
})

$('#res').css({marginTop:'-50%',position:'absolute'})
