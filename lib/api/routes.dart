class APIRoutes {
  static var getFacultyGroups = (String faculty) =>
      'https://rts.a6raywa1cher.com/reschedule-tsu-spring/faculties/$faculty/groups?full_table=false';

  static var getFaculties = () => 'https://rts.a6raywa1cher.com/reschedule-tsu-spring/faculties';
}
