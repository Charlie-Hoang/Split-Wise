//
//  SplitwiseService.swift
//  SplitwiseApp
//
//  Created by Charlie on 3/19/19.
//  Copyright © 2019 CuongHH. All rights reserved.
//

import Foundation
import RealmSwift

class SplitwiseService{
    let group: Group
    init(group: Group){
        self.group = group
    }
    func getExpenseDiary(member: Member) -> DiaryResult{
        
        var expenses = [Expense]()
        var totalAmount = 0.0
        for party in group.parties{
            for mem in party.members{
                if mem.id == member.id{
                    let expense = Expense(member: member)
                    expense.party = party
                    expense.amount = expenseOf(member: member, in: party)
                    totalAmount = totalAmount + (expense.amount ?? 0)
                    expenses.append(expense)
                    break
                }
            }
        }
        if expenses.isEmpty{
            return .failed(SplitError.emptyExpense)
        }
        return .success(expenses, totalAmount)
    }
    
    func getDebts() -> DebtResult{
        var creditors = [(Member, Double)]()
        var debtors = [(Member, Double)]()
        for member in group.members{
            let diary = getExpenseDiary(member: member)
            switch diary{
            case .success(_, let amount):
                if amount>0{
                    creditors.append((member, amount))
                }else if amount<0{
                    debtors.append((member, amount))
                }
            case .failed(let error):
                print(error.errorMessage)
            }
        }
        var debts = [Debt]()
        var creditIndex = 0, debtIndex = 0
        var remainAmount = 0.0
        while creditIndex<creditors.count || debtIndex<debtors.count {
            let creditor = creditors[creditIndex]
            let debtor = debtors[debtIndex]
            
            if remainAmount == 0{
                remainAmount = creditor.1 + debtor.1
            }else if remainAmount > 0{
                remainAmount += debtor.1
            }else{
                remainAmount += creditor.1
            }
            
            if remainAmount == 0{
                debts.append(Debt(creditor: creditor.0, debtor: debtor.0, amount: -debtor.1))
                debtIndex += 1
                creditIndex += 1
            }else if remainAmount > 0{
                let debt = Debt(creditor: creditor.0, debtor: debtor.0, amount: -debtor.1)
                debts.append(debt)
                debtIndex += 1
            }else if (remainAmount < 0){
                 debts.append(Debt(creditor: creditor.0, debtor: debtor.0, amount: creditor.1))
                creditIndex += 1
            }
            
        }
        if debts.isEmpty {
            return .failed(SplitError.emptyDebt)
        }
        return .success(debts)
    }
}
//private
extension SplitwiseService{
    private func expenseForEachOfParty(party: Party) -> Double{
        if let value = party.amount.value{
            return value/Double(party.members.count)
        }
        return 0
    }
    private func expenseOf(member: Member, in party: Party) -> Double{
        let expenseForEach = expenseForEachOfParty(party: party)
        if party.paidBy?.id == member.id{
            return (party.amount.value ?? 0) - expenseForEach
        }
        return -expenseForEach
    }
}
