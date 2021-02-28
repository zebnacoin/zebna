// Copyright (c) 2011-2014 The Bitcoin Core developers
// Distributed under the MIT software license, see the accompanying
// file COPYING or http://www.opensource.org/licenses/mit-license.php.

#ifndef ZEBNA_QT_ZEBNAADDRESSVALIDATOR_H
#define ZEBNA_QT_ZEBNAADDRESSVALIDATOR_H

#include <QValidator>

/** Base58 entry widget validator, checks for valid characters and
 * removes some whitespace.
 */
class ZebnaAddressEntryValidator : public QValidator
{
    Q_OBJECT

public:
    explicit ZebnaAddressEntryValidator(QObject *parent);

    State validate(QString &input, int &pos) const;
};

/** Zebna address widget validator, checks for a valid zebna address.
 */
class ZebnaAddressCheckValidator : public QValidator
{
    Q_OBJECT

public:
    explicit ZebnaAddressCheckValidator(QObject *parent);

    State validate(QString &input, int &pos) const;
};

#endif // ZEBNA_QT_ZEBNAADDRESSVALIDATOR_H
