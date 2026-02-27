//auto scalling launch configuration
resource "aws_launch_configuration" "lc" {
  name_prefix   = "lc-"
  image_id      = lookup(var.AMIS, var.AWS_REGION)
  instance_type = "t2.micro"
  key_name = aws_key_pair.levelup_key.key_name

}

resource "aws_key_pair" "levelup_key" {
    key_name = "levelup_key"
    public_key = file(var.PATH_TO_PUBLIC_KEY)
}
//auto scalling group
resource "aws_autoscaling_group" "levelup_asg" {
  name_prefix        = "levelup_asg-"
  max_size           = 2
  min_size           = 1
  desired_capacity   = 1
  launch_configuration = aws_launch_configuration.lc.name
  vpc_zone_identifier = ["us-east-2b","us-east-2a"]
  health_check_grace_period = 200
  health_check_type = "EC2"
  force_delete = true
  tag {
    key = "Name"
    value = "Level Up Customer EC2 Instace "
    propagate_at_launch = true
  }

}
//auto scalling policy
resource "aws_autoscaling_policy" "levelup_policy" {
  name                   = "levelup_policy"
  autoscaling_group_name = aws_autoscaling_group.levelup_asg.name
  scaling_adjustment     = 1
  adjustment_type        = "ChangeInCapacity"
  cooldown = "200"
  policy_type = "SimpleScaling"


}
//cloud watch alarm for auto scalling
resource "aws_cloudwatch_metric_alarm" "cpu_alarm" {    
    alarm_name          = "cpu_alarm"
    comparison_operator = "GreaterThanThreshold"
    evaluation_periods  = "2"
    metric_name         = "CPUUtilization"
    namespace           = "AWS/EC2"
    period              = "120"
    statistic           = "Average"
    threshold           = "70"
    
    dimensions = {
        AutoScalingGroupName = aws_autoscaling_group.levelup_asg.name
    }
    
    alarm_actions = [aws_autoscaling_policy.levelup_policy.arn]
    }
    //auto descalling policy
resource "aws_autoscaling_policy" "levelup_descalling_policy" {
  name                   = "levelup_descalling_policy"
  autoscaling_group_name = aws_autoscaling_group.levelup_asg.name
  scaling_adjustment     = -1
  adjustment_type        = "ChangeInCapacity"
  cooldown = "200"
  policy_type = "SimpleScaling"
}
//cloud watch alarm for auto descalling
resource "aws_cloudwatch_metric_alarm" "cpu_descalling_alarm" {   
    alarm_name          = "cpu_descalling_alarm"
    comparison_operator = "LessThanThreshold"
    evaluation_periods  = "2"
    metric_name         = "CPUUtilization"
    namespace           = "AWS/EC2"
    period              = "120"
    statistic           = "Average"
    threshold           = "30"
    
    dimensions = {
        AutoScalingGroupName = aws_autoscaling_group.levelup_asg.name
    }
    
    alarm_actions = [aws_autoscaling_policy.levelup_descalling_policy.arn]
    }