$(function(){

  // All pages
  if($('body.facebook_posts').length) {
    // Colorbox for images
    $(".post-image-link").colorbox({rel: 'post-image-link'});
  };

  // List page
  if($('body.facebook_posts.index').length){
    $('.delete-post, .delete-draft').on('click', function(e){
      e.preventDefault();
      e.stopPropagation()
      var excerpt = $(this).parents('tr').children('.excerpt').text();
      var href = $(this).attr('href');
      swal({
        title: "Are you sure?",
        text: "You are about to delete the post with excerpt \""+ excerpt +"\"",
        type: "warning",   showCancelButton: true,
        confirmButtonColor: "#CB100A",
        confirmButtonText: "Yes, delete it!",
        closeOnConfirm: false
        },
          function(){
            window.location = href;
      });
    });
  }

  // Show Page
  if($('body.facebook_posts.show').length){
    // Modal for delete posts
    $('.delete-post').on('click', function(e){
      e.preventDefault();
      e.stopPropagation()
      var href = $(this).attr('href');
      swal({
            title: "Are you sure?",
            text: "You are about to delete this post",
            type: "warning",   showCancelButton: true,
            confirmButtonColor: "#CB100A",
            confirmButtonText: "Yes, delete it!",
            closeOnConfirm: false
          },
          function(){
            window.location = href;
          });
    });

    // Tooltip for insights
    $('[data-toggle="tooltip"]').tooltip().on('click', function(e){
      e.preventDefault();
      e.stopPropagation()
    });
  }

  if($('body.facebook_posts.new, body.facebook_posts.edit, body.facebook_posts.update').length){
    Dropzone.options.newFacebookPost = { // The camelized version of the ID of the form element

      // The configuration we've talked about above
      autoProcessQueue: false,
      uploadMultiple: true,
      parallelUploads: 100,
      maxFiles: 100,
      addRemoveLinks: true,
      previewsContainer: '.dropzone-previews',
      paramName: 'image_attachments',


      // The setting up of the dropzone
      init: function() {
        var myDropzone = this;

        // First change the button to actually tell Dropzone to process the queue.
        this.element.querySelector("input[type=submit]").addEventListener("click", function(e) {
          // Make sure that the form isn't actually being sent.
          if($('.dz-image').length){
            e.preventDefault();
            e.stopPropagation();
            myDropzone.processQueue();
          }
        });

        // Listen to the sendingmultiple event. In this case, it's the sendingmultiple event instead
        // of the sending event because uploadMultiple is set to true.
        this.on("sendingmultiple", function() {
          // Gets triggered when the form is actually being sent.
          // Hide the success button or the complete form.
        });
        this.on("successmultiple", function(files, response) {
          // Gets triggered when the files have successfully been sent.
          // Redirect user or notify of success.
        });
        this.on("errormultiple", function(files, response) {
          // Gets triggered when there was an error sending the files.
          // Maybe show form again, and notify user of error
        });

        this.on('queuecomplete', function (file) {
          window.location = '/facebook_posts'
        });
      }

    }
  }

});
