abstract class UserEvent {}

class GetUserEvent extends UserEvent {
  final String id;
  GetUserEvent(this.id);
}

class GetUserAllEvent extends UserEvent {}
