
function ec2-desc() {
    local filter="Name=key-name,Values=$1"
    local query="Reservations[].Instances[].$2"
    aws ec2 describe-instances \
        --filters $filter \
        --filters "Name=instance-state-name,Values=running" \
        --query $query \
        | sed -n 2p \
        | tr -d '"' \
        | tr -d ' '
}

function create-cloud-dev() {
    aws ec2 run-instances \
        --image-id ami-0c5199d385b432989 \
        --instance-type t2.micro \
        --key-name cloud-dev \
        --user-data file://~/dotfiles/aws/startup.sh
}

function aws-ec2() {
    aws ec2 $1 --instance-ids $(ec2-desc $2 InstanceId)
}

function cloud-dev-instance-id() {
    ec2-desc cloud-dev InstanceId
}

function cloud-dev-dns() {
    ec2-desc cloud-dev PublicDnsName
}

function ssh-aws-cloud-dev() {
    ssh -i ~/.aws/cloud-dev.pem ubuntu@$(cloud-dev-dns)
}

function mosh-aws-cloud-dev() {
    mosh -ssh="ssh -i ~/.aws/cloud-dev.pem" ubuntu@$(cloud-dev-dns)
}

function aws-terminate-cloud-dev() {
    aws ec2 terminate-instances --instance-ids $(cloud-dev-instance-id)
}
