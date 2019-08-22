console.log("Loading script");

window.onload = () => {
  $('#myInput').on("keyup", function() {
    var value = $(this).val().toLowerCase();
    $("#myTable tr").filter(function() {
      $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
    });
  });


  $("#jobsTable #myTable tr").on("click", function(e){
    let jobID = this.dataset.job;
    $("#modal-id-"+jobID).modal('show');
  })
};