"""Helper keywords and functions collected here"""

import allure
from operator import itemgetter
from robot.api.deco import keyword

ROBOT_AUTO_KEYWORDS = False


@keyword
def check_list_differences(list_1: list, list_2: list, key: str):
    """
    Compare givens lists containing dictionaries. Before comparison,
    sorts lists based on key having unique value, both lists should
    have this same key available.

    Parameters
    ----------
    list_1 : list
        First list containing dictionaries
    list_2 : list
        Second list containing dictionaries
    key : str
        dictionary key which both lists have and has unique value

    Returns
    -------
        Empty list if lists are equal or if not, then returns all different pairs as a list,
        or list containing original lists as sorted, if lengths are different.
    """
    s_list_1, s_list_2 = sort_lists(list_1, list_2, key)
    try:
        pairs = zip(s_list_1, s_list_2, strict=True)
        result = [(x, y) for x, y in pairs if x != y]
        return result
    except ValueError:
        return [s_list_1, s_list_2]

@allure.step('Sort lists')
def sort_lists(list_1: list, list_2: list, key: str):
    """
    Sorts lists containing dictionaries based on given dictionary key. Key should be found
    from all dictionaries and it's value should be unique.

    Parameters:
    -----------
    list_1 : list
        First list containing dictionaries
    list_2 : list
        Second list containing dictionaries
    key : str
        dictionary key which both lists have in all dictionaries and has unique value

    Returns:
    --------
    Returns new sorted lists

    Raises:
    ------
    Raises key error if given key is not suitable
    """
    try:
        sorted_1, sorted_2 = [sorted(l, key=itemgetter(key))
                              for l in (list_1, list_2)]
        return sorted_1, sorted_2
    except KeyError as e:
        raise KeyError(f'Key {key} is not suitable key for sorting') from e
