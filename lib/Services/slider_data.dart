
import 'package:newsapp/Models/slider_model.dart';

List<SliderModel>getSliders(){

  List<SliderModel>slider=[];
  SliderModel catergoryModel = SliderModel();

  catergoryModel.name="Bow to the Authority of Salienforce";
  catergoryModel.image="assets/images/buisness.jpg";
  slider.add(catergoryModel);
  catergoryModel=new SliderModel();

  catergoryModel.name="Bow to the Authority of Salienforce";
  catergoryModel.image="assets/images/entertainment.jpg";
  slider.add(catergoryModel);
  catergoryModel=new SliderModel();



  catergoryModel.name="Bow to the Authority of Salienforce";
  catergoryModel.image="assets/images/health.jpg";
  slider.add(catergoryModel);
  catergoryModel=new SliderModel();


  return slider;
}