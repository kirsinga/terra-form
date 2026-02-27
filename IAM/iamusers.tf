resource "aws_iam_user" "adminuser1" {
  name = "adminuser1"
}
resource "aws_iam_user" "adminuser2" {
  name = "adminuser2"
  
}
 resource "aws_iam_group" "admingrouping" {
      name="admingrouping"
 }

 resource "aws_iam_group_membership" "adminmembership" {
      name = "adminmembership"
      users = [aws_iam_user.adminuser1.name, aws_iam_user.adminuser2.name]
      group = aws_iam_group.admingrouping.name
 }
 resource "aws_iam_policy_attachment" "adminuserattach" {
      name = "adminuserattach"
      policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
      groups = [aws_iam_group.admingrouping.name]
 }