awk 'BEGIN{
	print "g=DiGraph()"
}
{
	print "g.add_edges([(\"" $1 "\",\"" $2 "\")])"

}END{
print "g.show()"
print "g.connected_components()"
}' $1
