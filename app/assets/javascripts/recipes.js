$(document).ready(function() {
    $("#owner a.add_fields").
      data("association-insertion-position", 'before').
      data("association-insertion-node", 'this');

    $('#owner').bind('cocoon:after-insert',
         function() {
           $("#owner_from_list").hide();
           $("#owner a.add_fields").hide();
         });
    $('#owner').bind("cocoon:after-remove",
         function() {
           $("#owner_from_list").show();
           $("#owner a.add_fields").show();
         });

    $("#tags a.add_fields").
      data("association-insertion-position", 'before').
      data("association-insertion-node", 'this');

    $('#tags').bind('cocoon:after-insert',
         function(e, tag) {
             console.log('inserting new tag ...');
             $(".project-tag-fields a.add-tag").
                 data("association-insertion-position", 'after').
                 data("association-insertion-node", 'this');
             $(this).find('.project-tag-fields').bind('cocoon:after-insert',
                  function() {
                    console.log('insert new tag ...');
                    console.log($(this));
                    $(this).find(".tag_from_list").remove();
                    $(this).find("a.add_fields").hide();
                  });
         });

    $('.project-tag-fields').bind('cocoon:after-insert',
        function(e) {
            console.log('replace OLD tag ...');
            e.stopPropagation();
            console.log($(this));
            $(this).find(".tag_from_list").remove();
            $(this).find("a.add_fields").hide();
        });


    $('#tasks').bind('cocoon:before-insert', function(e,task_to_be_added) {
        console.log(task_to_be_added);
        task_to_be_added.fadeIn('slow');
    });

    $('#tasks').bind('cocoon:after-insert', function(e, added_task) {
        //added_task.css("background","red");
    });

    $('#tasks').bind('cocoon:before-remove', function(e, task) {
        $(this).data('remove-timeout', 1000);
        task.fadeOut('slow');
    })

    //$('body').tabs();
});
// recipe js portfolio project recipe

$(() => {
  listenForAllRecipesClick()
});
// chekoh for click on navbar
const listenForAllRecipesClick = () => {
  $('#all-recipes').on('click', e => {
    e.preventDefault();
    history.pushState(null, null, "recipes");
    getAllRecipes();
  })
  $(document).on('click', ".show-recipe", function(e){
    e.preventDefault()

    let id = $(this).attr('data-id')
    fetch(`/recipes/${id}.json`)
     .then(response => response.json())
       .then(recipe => {
         $('.app-container').html('')
         let newRecipe = new Recipe(recipe)
         let showRecipeHTML = newRecipe.recipeShowHTML()
         $(".app-container").append(showRecipeHTML)
     })
  })
}

const listenForAllRecipesClick = () => {
  $('#all-recipes').on('click', e => {
    e.preventDefault();
    history.pushState(null, null, "recipes");
    getAllRecipes();
  })
  $(document).on('click', ".show-recipe", function(e){
    e.preventDefault()

    let id = $(this).attr('data-id')
    fetch(`/recipes/${id}.json`)
     .then(response => response.json())
       .then(recipe => {
         $('.app-container').html('')
         let newRecipe = new Recipe(recipe)
         let showRecipeHTML = newRecipe.recipeShowHTML()
         $(".app-container").append(showRecipeHTML)
     })
  })
}

const getAllRecipes = () => {
  fetch(`/recipes.json`)
    .then(response => response.json())
      .then(recipes => {
        $('.app-container').html('')
        recipes.forEach((recipe) => {
          let newRecipe = new Recipe(recipe)
          let allRecipesHTML = newRecipe.recipeIndexHTML()
          // debugger
          $(".app-container").append(allRecipesHTML);
          // console.log(newRecipe);
    })
  })
}



class Recipe {
  constructor(obj){
    this.id = obj.id
    this.title = obj.title
    this.description = obj.description
    this.image = obj.image
    this.user_email = obj.user.email
    // debugger
    // this.user.email = obj.user.email
    this.categories = obj.categories
    this.ingredients = obj.ingredients
    this.directions = obj.directions
    this.comments = obj.comments
  }
  static newRecipeForm(){
    return(
      `

      `
    )
  }
}

Recipe.prototype.recipeIndexHTML = function(){

  return(
    `
      <div class="row" id="recipes-list">
        <div class="col-md-4">
          <div class="recipe">
            <div class="image_wrapper">
              <a class="show-recipe" href="/recipes/${this.id}" data-id="${this.id}"><img src="${this.image}"></a>
            </div>
            <h4><a class="show-recipe" data-id="${this.id}" href="/recipes/${this.id}">${this.title}</a></h4>
          </div>
        </div>
      </div>
    `
  )
}

Recipe.prototype.recipeShowHTML = function(){
  let recipeComments = this.comments.map(comment => {
    return(
      `

      <div id="render-comments">
          <p class="comment_title"><strong>${comment.title}<strong></p>
          <p class="comment_body">${comment.title}</p>
          <small class="comment_time">by <strong>${this.user_email}</strong></small>
      </div>
      `
    )
  })

  let recipeCategories = this.categories.map(category => {
    return (
      `
      <p class="btn btn-secondary">${category.name}</p>
      `
    )
  }).join('')

}
