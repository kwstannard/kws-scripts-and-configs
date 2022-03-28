function kube-running-pod()
{
  kubectl get pods -n $1 -l app.kubernetes.io/name=$2 -o custom-columns=:metadata.name
}

function kube-exec()
{
  ns=$1
  shift
  name=$1
  shift;
  kubectl -n "$ns" exec $(kube-running-pod "$ns" "$name") -it -- "$@"
}
