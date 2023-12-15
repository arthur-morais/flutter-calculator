class HandleButtons {
  HandleButtons._();

  static handleButtons({
    required String text,
    required String userInput,
    required String result,
  }) {
    if (text == 'C') {
      // userInput = '';
      // result = '0';
      if (userInput.isNotEmpty) {
        userInput = userInput.substring(0, userInput.length - 1);
        return;
      } else {
        return null;
      }
    }

    userInput = userInput + text;
  }
}
