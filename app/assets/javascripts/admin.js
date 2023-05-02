//= require jquery2
//= require jquery_ujs
//= require cocoon

$(function() {
  $('.js-datetimepicker').datetimepicker({
    locale: 'ja',
    sideBySide: true,
    toolbarPlacement: 'bottom',
    showTodayButton: true,
    showClear: true,
    format: 'YYYY-MM-DD HH:mm'
  });
  $('.js-select2').select2();
  autosize($('.js-autosize'));
  return $('.js-article-block-forms').each(function() {
    var $root, reload, uuid;
    $root = $(this);
    uuid = $root.data('article-uuid');
    $root.on('ajax:success', '.js-insert-article-block', function() {
      return reload();
    });
    $root.on('ajax:error', '.js-insert-article-block', function() {
      return alert('エラーが発生しました');
    });
    $root.on('ajax:complete', '.js-insert-article-block', function() {
      $root.find('.modal').modal('hide');
      $('body').removeClass('modal-open');
      $('.modal-backdrop').remove();
    });
    $root.on('ajax:before', '.js-remove-article-block', function() {
      return confirm('ブロックを削除しますか？');
    });
    $root.on('ajax:success', '.js-remove-article-block', function() {
      return reload();
    });
    $root.on('ajax:error', '.js-remove-article-block', function() {
      return alert('エラーが発生しました');
    });
    $root.on('ajax:success', '.js-swap-level-article-block', function() {
      return reload();
    });
    $root.on('ajax:error', '.js-swap-level-article-block', function() {
      return alert('エラーが発生しました');
    });
    $root.on('ajax:success', '.js-edit-article-block', function(event, data) {
      var $content;
      $content = $(this).parents('.js-article-block-content');
      $content.html(data);
      return $content.find('.js-article-block-editor').articleBlockEditor();
    });
    $root.on('ajax:success', '.js-update-article-block', function() {
      return reload();
    });
    $root.on('ajax:error', '.js-update-article-block', function() {
      return alert('エラーが発生しました');
    });
    $root.on('click', '.js-cancel-article-block', function(event) {
      event.preventDefault();
      return reload();
    });
    reload = function() {
      return $.ajax({
        method: 'GET',
        url: "/admin/articles/" + uuid + "/article_blocks",
        dataType: 'html',
        cache: false
      }).done((function(_this) {
        return function(data) {
          return $root.html(data);
        };
      })(this)).fail((function(_this) {
        return function() {
          return alert('エラーが発生しました');
        };
      })(this));
    };
    return reload();
  });
});
