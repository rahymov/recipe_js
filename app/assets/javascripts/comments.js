$(function(){
  listenForCommentSubmit();
})

function listenForCommentSubmit(){
  $("#new_comment").on('submit', function(e){
    e.preventDefault();
    // alert("create comment submitted")
    let url = this.action
    console.log(url)
    data = {
      'authenticity_token': $("input[name='authenticity_token']").attr("value"),
      'comment':{
        'title': $("#comment_title").val(),
        'body': $("#comment_body").val()
      }
    }

    $.ajax({
      type: "POST",
      data: data,
      url: url,
      success: function(response){
        $("#comment_title").val("")
        $("#comment_body").val("")
        let $content = $("#render-comments")
        $content.append(response)
        $("#create-comment").prop('disabled', false);
      }
    })
  })
}
