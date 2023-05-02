User.seed(
  :id,
  { id: 1, name: 'admin', crypted_password: User.encrypt('password'), role: :admin },
  { id: 2, name: 'editor', crypted_password: User.encrypt('password'), role: :editor },
  { id: 3, name: 'writer', crypted_password: User.encrypt('password'), role: :writer },
)
