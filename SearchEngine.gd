extends Node

class TermSorter:
	static func sort_by_label(a, b):
		if a.label < b.label:
			return true
		else:
			return false

class SuggestionSorter:
	static func sort_by_count(a, b):
		if a.count > b.count:
			return true
		else:
			return false

class TermSearcher:
	static func bsearch(a, val):
		if a.label == val:
			return true
		else:
			return false

var terms = [
	{
		"label": "",
		"suggestions": []
	}
]

func search_terms_containing_label(label):
	if label == "":
		return terms
	else:
		var close_terms = []
		
		for term in terms:
			if label in term.label:
				close_terms.append(term)
		
		return close_terms

func get_term(label):
	terms.sort_custom(TermSorter, "sort_by_label")
	var search_terms = search_terms_containing_label(label)
	if search_terms.size() > 0:
		return search_terms[0]
	else:
		return null

func get_suggestions(label):
	var term = get_term(label)
	if term == null:
		return []
	else:
		term.suggestions.sort_custom(SuggestionSorter, "sort_by_count")
		return term.suggestions

func add_term(new_label):
	var term = get_term(new_label)
	if term == null:
		term = {
			"label": new_label,
			"suggestions": []
		}
		terms.push_back(term)
	return term

func add_suggestion(term_label, suggestion_label):
	var suggestions = get_term(term_label).suggestions
	
	for suggestion in suggestions:
		if suggestion.label == suggestion_label:
			suggestion.count += 1
			return suggestion
	
	var new_suggestion = {
		"label": suggestion_label, "count": 1
	}
	suggestions.push_back(new_suggestion)
	return new_suggestion
