* Distribution Viewer SQL Function
This is a table-valued function that takes a table-valued parameter as its input. This is a table with a single column consisting of a float. It returns a table that has to be ordered in the right way according to the Y value. Each line represents a row of the histogram in Unicode characters (only three are used for the actual histogram). The histogram looks better if you put the title in the alias for the Line column.

The histogram must be viewed in a monospaced font, and if it is used in SSMS, this is likely to be the case unless you view it in ‘grid’ mode. You must have ‘results to text’ selected.

The current version is here in Github. A version is attached to the article on Simple-Talk but we don’t always succeed in keeping that up-to-date. 
