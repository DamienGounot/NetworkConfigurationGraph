awk 'BEGIN{
	print "g=DiGraph()"
}
{
	if($2 == "SOLO")
	{
	print "g.add_vertex(\"" $1 "\")"
	}
	else
	{
	print "g.add_edges([(\"" $1 "\",\"" $2 "\")])"
	}

}END{
print "g.show()"
print "g.connected_components()"
}' $1
