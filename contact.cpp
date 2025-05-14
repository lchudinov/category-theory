struct Contact
{
  enum
  {
    isPhone,
    isEmail
  } tag;
  union
  {
    int pnoneNum;
    const char *emailAddr;
  };
};

Contact PhoneNum(int n) {
  Contact c;
  c.tag = Contact::isPhone;
  c.pnoneNum = n;
  return c;
}