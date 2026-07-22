class RoleModel {
  final String id;
  final String title;
  final String description;
  final String icon;
  final List<String> requiredSkills;
  final String color;
  final Map<String, String> resources;

  const RoleModel({
    required this.id,
    required this.title,
    required this.description,
    required this.icon,
    required this.requiredSkills,
    required this.color,
    required this.resources,
  });
}
