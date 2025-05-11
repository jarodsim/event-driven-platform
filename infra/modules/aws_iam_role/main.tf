resource "aws_iam_role" "this" {
  name               = var.name
  assume_role_policy = var.assume_role_policy
  description        = var.description
}

resource "aws_iam_policy" "custom" {
  count       = length(var.inline_policies)
  name        = "${var.name}-${count.index}-policy"
  description = lookup(var.inline_policies[count.index], "description", null)

  policy = jsonencode({
    Version   = "2012-10-17"
    Statement = lookup(var.inline_policies[count.index], "statements", [])
  })
}

resource "aws_iam_role_policy_attachment" "managed" {
  for_each = toset(var.managed_policy_arns)

  role       = aws_iam_role.this.name
  policy_arn = each.value
}

resource "aws_iam_role_policy_attachment" "inline_attach" {
  count      = length(var.inline_policies)
  role       = aws_iam_role.this.name
  policy_arn = aws_iam_policy.custom[count.index].arn
}
