resource "aws_security_group" "sg" {
    for_each = var.sg_config
    name = each.value.sg_nm
    description = each.value.description
    vpc_id = var.vpc_id
    tags = {
        Name = each.value.sg_nm
    }
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
        description = "Allow all outbound traffic"
    }
}

resource "aws_security_group_rule" "ingress" {
    count = length(var.sg_ingress_rule) > 0 ? length(var.sg_ingress_rule) : 0
    security_group_id = aws_security_group.sg[var.sg_ingress_rule[count.index].sg_nm].id
    type = "ingress"
    cidr_blocks = var.sg_ingress_rule[count.index].cidr_blocks == [] ? null : var.sg_ingress_rule[count.index].cidr_blocks
    prefix_list_ids = var.sg_ingress_rule[count.index].prefix_list_ids == [] ? null : var.sg_ingress_rule[count.index].prefix_list_ids
    from_port = var.sg_ingress_rule[count.index].from_port == null ? null : var.sg_ingress_rule[count.index].from_port
    to_port = var.sg_ingress_rule[count.index].to_port == null ? null : var.sg_ingress_rule[count.index].to_port
    protocol = var.sg_ingress_rule[count.index].protocol == "" ? null : var.sg_ingress_rule[count.index].protocol
    source_security_group_id = try(var.sg_ingress_rule[count.index].source_security_group_id, null)
    self = try(var.sg_ingress_rule[count.index].self, null)
    description = var.sg_ingress_rule[count.index].description == "" ? null : var.sg_ingress_rule[count.index].description

}