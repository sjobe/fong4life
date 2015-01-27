$(function(){
  $('#closeEmergencyModal #emergency_donor_id').select2({
    width: '100%'
    });
  
    $('#closeEmergencyModal #select-matched-donor').hide(); // VERY BAD! Always do style initializations in stylesheet
  
    $('#closeEmergencyModal #emergency_match_found').on('change', function(){
      if($(this).val() === 'true'){
        $('#closeEmergencyModal #select-matched-donor').show();
      } else {
        $('#closeEmergencyModal #select-matched-donor').hide();
      }
    });
});