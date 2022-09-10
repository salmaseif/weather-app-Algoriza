class Coordinates
{
  double? latitude;
   double? longitude;
  Coordinates({this.longitude, this.latitude});
  factory Coordinates.fromjson(Map m)
  {

return Coordinates(longitude: m['lon'], latitude: m['lat']);
  }




}