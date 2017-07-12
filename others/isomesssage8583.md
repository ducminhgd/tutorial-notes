# ISO Message 8583

## Variable Length Field

*Each `.` is a number*

| Field | Type       | Usage                                      |
|-------|------------|--------------------------------------------|
| 2     | n .. 19    | Primary account number (PAN)               |
| 28    | x+n 8      | Amount, transaction fee                    |
| 29    | x+n 8      | Amount, settlement fee                     |
| 30    | x+n 8      | Amount, transaction processing fee         |
| 31    | x+n 8      | Amount, settlement processing fee          |
| 32    | n ..11     | Acquiring institution identification code  |
| 33    | n ..11     | Forwarding institution identification code |
| 34    | ns ..28    | Primary account number, extended           |
| 35    | z ..37     | Track 2 data                               |
| 36    | n ...104   | Track 3 data                               |
| 44    | an ..25    | Additional response data                   |
| 45    | an ..76    | Track 1 data                               |
| 46    | an ...999  | Additional data - ISO                      |
| 47    | an ...999  | Additional data - national                 |
| 48    | an ...999  | Additional data - private                  |
| 54    | an ...120  | Additional amounts                         |
| 55    | ans ...999 | ICC Data - EMV having multiple tags        |
| 56    | ans ...999 | Reserved ISO                               |
| 57    | ans ...999 | Reserved national                          |
| 58    | ans ...999 | Reserved national                          |
| 59    | ans ...999 | Reserved national                          |
| 60    | ans ...999 | Reserved national                          |
| 61    | ans ...999 | Reserved private                           |
| 62    | ans ...999 | Reserved private                           |
| 63    | ans ...999 | Reserved private                           |
| 97    | x+n 16     | Amount, net settlement                     |
| 99    | n ..11     | Settlement institution identification code |
| 100   | n ..11     | Receiving institution identification code  |
| 101   | ans ..17   | File name                                  |
| 102   | ans ..28   | Account identification 1                   |
| 103   | ans ..28   | Account identification 2                   |
| 104   | ans ...100 | Transaction description                    |
| 105   | ans ...999 | Reserved for ISO use                       |
| 106   | ans ...999 | Reserved for ISO use                       |
| 107   | ans ...999 | Reserved for ISO use                       |
| 108   | ans ...999 | Reserved for ISO use                       |
| 109   | ans ...999 | Reserved for ISO use                       |
| 110   | ans ...999 | Reserved for ISO use                       |
| 111   | ans ...999 | Reserved for ISO use                       |
| 112   | ans ...999 | Reserved for national use                  |
| 113   | ans ...999 | Reserved for national use                  |
| 114   | ans ...999 | Reserved for national use                  |
| 115   | ans ...999 | Reserved for national use                  |
| 116   | ans ...999 | Reserved for national use                  |
| 117   | ans ...999 | Reserved for national use                  |
| 118   | ans ...999 | Reserved for national use                  |
| 119   | ans ...999 | Reserved for national use                  |
| 120   | ans ...999 | Reserved for private use                   |
| 121   | ans ...999 | Reserved for private use                   |
| 122   | ans ...999 | Reserved for private use                   |
| 123   | ans ...999 | Reserved for private use                   |
| 124   | ans ...999 | Reserved for private use                   |
| 125   | ans ...999 | Reserved for private use                   |
| 126   | ans ...999 | Reserved for private use                   |
| 127   | ans ...999 | Reserved for private use                   |
