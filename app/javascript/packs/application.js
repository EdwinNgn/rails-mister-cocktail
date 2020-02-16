import 'bootstrap';
import $ from 'jquery';
import 'select2';

import 'select2/dist/css/select2.css';

const cards = document.querySelectorAll(".card-category")

const addClassHide = (event) => {
  event.currentTarget.firstElementChild.classList.toggle("hide");
  event.currentTarget.childNodes[3].classList.toggle("hide");
};

const hideWhenHover = (card) => {
  card.addEventListener("click", addClassHide);
};

cards.forEach(hideWhenHover);


$(document).ready(function() {
  $(".js-example-basic-multiple-limit").select2({
  maximumSelectionLength: 2,
  placeholder: "Looking for an ingredient?"
  });
});





