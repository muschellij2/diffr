HTMLWidgets.widget({

  name: 'diffr',

  type: 'output',

  initialize: function(el, width, height) {

    return {
      // TODO: add instance fields as required
    }

  },

  renderValue: function(el, x, instance) {
    document.body.style.overflow = "auto";
    /*
    el.innerText = x.message;
    el.innerText = x.file1;
    el.outerText = x.file2;
    */
    console.log(el.id);
    var myid = '#' + el.id;
    console.log(myid);
    console.log(x);
    console.log(x.wordWrap);
    //el.html(
      $(myid).html(
        codediff.buildView(x.f1, x.f2, {
          beforeName: x.file1,
          afterName: x.file2,
          contextSize: x.contextSize,
          minJumpSize: x.minJumpSize,
          wordWrap: x.wordWrap
        })
      )
    //)
    ;
/*
$(el).append(
        codediff.buildView(x.f1, x.f2, {
        beforeName: x.file1,
        afterName: x.file2,
        contextSize: 8,
        minJumpSize: 5,
        wordWrap: true
    }));
    */

  },

  resize: function(el, width, height, instance) {

  }

});
