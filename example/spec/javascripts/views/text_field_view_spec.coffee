describe "text field view", ->
  beforeEach ->
    setFixtures "<div id='text_field_view'></div>"
    @model = new Example.Models.Thing
      name: "bob"
    @textFieldView = new Backtastic.Views.TextFieldView
      model: @model
      field: "name"
      label: "Name"
      el: $("#text_field_view")
      parentView: new Example.Views.FormView
    @textFieldView.render()
  it "renders has a value", ->
    expect(@textFieldView.$("input[name=name]").val()).toEqual "bob"
  it "puts a label on it", ->
    expect(@textFieldView.$("label[for=name]")).toExist()
    expect(@textFieldView.$("label[for=name]")).toHaveText /Name/

  describe "updating model", ->
    beforeEach ->
      @textFieldView.$("input").val("Not bob")
      @textFieldView.updateModel()
    it "should update the model", ->
      expect(@model.get("name")).toEqual "Not bob"
  describe "displaying errors", ->
    beforeEach ->
      @textFieldView.displayErrors
        name: ["totally borked"]
    it "should add the error class", ->
      expect(@textFieldView.$el).toHaveClass "error"
    it "should add the error message", ->
      expect(@textFieldView.$("span.help-inline")).toHaveText "totally borked"
    describe "and then setting model attribute to something valid", ->
      beforeEach ->
        @model.set name: "Wut"
      it "should remove error class", ->
        expect(@textFieldView.$el).not.toHaveClass "error"
      it "should remove the error message", ->
        expect(@textFieldView.$("span.help-inline")).not.toExist()

    describe "again", ->
      beforeEach ->
        @textFieldView.displayErrors
          name: ["totally borked"]
      it "should only display it once", ->
        expect(@textFieldView.$("span.help-inline").size()).toEqual 1


