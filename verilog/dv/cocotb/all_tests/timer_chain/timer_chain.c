#include <openframe.h>

/*
 * SPDX-FileCopyrightText: 2020 Efabless Corporation
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 * SPDX-License-Identifier: Apache-2.0
 */

void main(){
    // chain
    timer1_chain(1);
    timer0_chain(1);
    // count down
    timer1_upcount(0);
    timer0_upcount(0);
    // one shot
    timer1_oneshot(1);
    timer0_oneshot(1);
    // enable
    timer1_enable(1);
    timer0_enable(1);
    // setting data
    timer1_data(0x1);
    timer0_data(0xF);
}
