awk 'BEGIN{
	print "g=DiGraph()"
}
{
	if($2 != $4)
	{
	print "g.add_edges([(\"" $2 "\",\"" $4 "\")])"
	}

}END{
print "g.show()"
print "g.connected_components()"
}' $1
