class Contact {
  final int id;
  final String fullName;
  final int accountNumber;

  Contact(this.id, this.fullName, this.accountNumber);

  @override
  String toString(){
    print("id: $id \nName: $fullName \nAccount: $accountNumber" );
    return "id: $id Name: $fullName Account: $accountNumber";
  }
}