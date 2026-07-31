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

function currentAjaxParams() {
  const form = $(".ajax-filters");

  if (form.length) {
    return form.serialize();
  }

  return {};
}

$(document).on("keyup", ".ajax-search", function () {
  const input = $(this);

  clearTimeout(searchTimer);

  searchTimer = setTimeout(function () {
    $.ajax({
      url: input.data("url"),
      type: "GET",
      dataType: "script",
      data: currentAjaxParams()
    });
  }, 300);
});

$(document).on("click", ".page-link", function (e) {
  e.preventDefault();

  $.ajax({
    url: $(this).attr("href"),
    type: "GET",
    dataType: "script",
    data: currentAjaxParams()
  });
});

$(document).on("change", ".ajax-sort, .ajax-filter", function () {
  $.ajax({
    url: $(this).data("url"),
    type: "GET",
    dataType: "script",
    data: currentAjaxParams()
  });
});

window.reloadTable = function () {
  $.ajax({
    url: $(this).data("url"),
    type: "GET",
    dataType: "script",
    data: currentAjaxParams()
  });
}