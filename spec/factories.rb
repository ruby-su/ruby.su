Factory.define :regular_user, :class => User do |f|
  f.sequence(:email) {|n| "user#{n}@gmail.com"}
  f.password "a12345Den123"
  f.password_confirmation "a12345Den123"
end
