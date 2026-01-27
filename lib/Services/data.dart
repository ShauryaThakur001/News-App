import 'package:newsapp/Models/catergoryModel.dart';

List<CatergoryModel>getCategories(){

  List<CatergoryModel>category=[];
  CatergoryModel catergoryModel = CatergoryModel();

  catergoryModel.categoryName="Buisness";
  catergoryModel.image="assets/images/buisness.jpg";
  category.add(catergoryModel);
  catergoryModel=new CatergoryModel();

  catergoryModel.categoryName="Entertainment";
  catergoryModel.image="assets/images/entertainment.jpg";
  category.add(catergoryModel);
  catergoryModel=new CatergoryModel();

  catergoryModel.categoryName="General";
  catergoryModel.image="assets/images/general.jpg";
  category.add(catergoryModel);
  catergoryModel=new CatergoryModel();

  catergoryModel.categoryName="Health";
  catergoryModel.image="assets/images/health.jpg";
  category.add(catergoryModel);
  catergoryModel=new CatergoryModel();

  catergoryModel.categoryName="Sports";
  catergoryModel.image="assets/images/sports.jpg";
  category.add(catergoryModel);
  catergoryModel=new CatergoryModel();

  return category;
}