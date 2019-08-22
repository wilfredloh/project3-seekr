console.log("Loading script");

window.onload = () => {

//To fix small margins on top and bottom of page
    var abc = document.body.innerHTML;
    var a = String(abc).replace(/\u200B/g,'');
    document.body.innerHTML = a;

//For search bar on index page
  $('#myInput').on("keyup", function() {
    var value = $(this).val().toLowerCase();
    $("#myTable tr").filter(function() {
      $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
    });
  });

//To show modal on index page
  $("#jobsTable #myTable tr").on("click", function(e){
    let jobID = this.dataset.job;
    $("#modal-id-"+jobID).modal('show');
  })

  $("#addButton").on("click", function(e){
    $("#add-new-modal").modal('show');
  })

};