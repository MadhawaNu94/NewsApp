import 'package:news_app/model/slider_model.dart';

List<sliderModel> getSliders() {
  List<sliderModel> slider = [];
  sliderModel categoryModel = new sliderModel();

  categoryModel.image = "images/business.jpg";
  categoryModel.name = "Bow tothe blah blah";
  slider.add(categoryModel);
  categoryModel = new sliderModel();

  categoryModel.image = "images/entertaainment.png";
  categoryModel.name = "Bow tothe blah blah";
  slider.add(categoryModel);
  categoryModel = new sliderModel();

  categoryModel.image = "images/general.jpg";
  categoryModel.name = "Bow tothe blah blah";
  slider.add(categoryModel);
  categoryModel = new sliderModel();

  return slider;
}
