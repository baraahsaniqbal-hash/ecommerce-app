// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"

import "bootstrap"
import "bootstrap/dist/css/bootstrap.css"

import $ from "jquery";
import jQuery from "jquery"
window.$ = $;
window.jQuery = jQuery;

Rails.start()
Turbolinks.start()
ActiveStorage.start()

let searchTimer;

$(document).on("keyup", ".ajax-search", function () {
  const input = $(this);

  clearTimeout(searchTimer);

  searchTimer = setTimeout(function () {
    // console.log(input.data("url"));
    // console.log(input.val());
    $.ajax({
      url: input.data("url"),
      method: "GET",
      dataType: "script",
      data: currentCategoryParams()
    });
  }, 300);
});

$(document).on("click", ".page-link", function (e) {
  e.preventDefault();
    // console.log($(this).attr("href"));
  $.ajax({
    url: $(this).attr("href"),
    type: "GET",
    dataType: "script",
    data: currentCategoryParams()
  });
});

$(document).on("change", ".ajax-sort", function () {
  $.ajax({
    url: $(this).data("url"),
    type: "GET",
    dataType: "script",
    data: currentCategoryParams()
  });
});

$(document).on("change", ".ajax-filter", function () {
  $.ajax({
    url: $(this).data("url"),
    type: "GET",
    dataType: "script",
    data: currentCategoryParams()
  });
});

window.currentCategoryParams = function () {
  return {
    search: $("#category-search").val(),
    sort: $("#category-sort").val(),
    status: $("#category-status").val()
  };
}

window.reloadCategories = function () {
  $.ajax({
    url: "/admin/categories",
    type: "GET",
    dataType: "script",
    data: currentCategoryParams()
  });
}