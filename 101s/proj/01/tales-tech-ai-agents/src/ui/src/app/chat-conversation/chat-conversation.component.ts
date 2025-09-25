import { AsyncPipe, CommonModule, JsonPipe } from '@angular/common';
import {
  ChangeDetectionStrategy,
  Component,
  ElementRef,
  HostListener,
  OnInit,
  signal,
  viewChild,
  viewChildren,
} from '@angular/core';
import { FormsModule } from '@angular/forms';
import { NgIcon, provideIcons } from '@ng-icons/core';
import {
  lucideBot,
  lucideBrain,
  lucideRefreshCw,
  lucideSendHorizontal,
} from '@ng-icons/lucide';
import {
  BrnAlertDialogContentDirective,
  BrnAlertDialogTriggerDirective,
} from '@spartan-ng/brain/alert-dialog';
import { BrnSeparatorComponent } from '@spartan-ng/brain/separator';
import {
  HlmAlertDialogActionButtonDirective,
  HlmAlertDialogCancelButtonDirective,
  HlmAlertDialogComponent,
  HlmAlertDialogContentComponent,
  HlmAlertDialogDescriptionDirective,
  HlmAlertDialogFooterComponent,
  HlmAlertDialogHeaderComponent,
  HlmAlertDialogTitleDirective,
} from '@spartan-ng/ui-alertdialog-helm';
import { HlmBadgeDirective } from '@spartan-ng/ui-badge-helm';
import { HlmButtonDirective } from '@spartan-ng/ui-button-helm';
import {
  HlmCardContentDirective,
  HlmCardFooterDirective,
  HlmCardHeaderDirective,
  HlmCardTitleDirective,
} from '@spartan-ng/ui-card-helm';
import { HlmToasterComponent } from '@spartan-ng/ui-sonner-helm';

import {
  BrnPopoverComponent,
  BrnPopoverContentDirective,
  BrnPopoverTriggerDirective,
} from '@spartan-ng/brain/popover';
import {
  HlmAlertDescriptionDirective,
  HlmAlertDirective,
} from '@spartan-ng/ui-alert-helm';
import { HlmFormFieldModule } from '@spartan-ng/ui-formfield-helm';
import { HlmIconDirective } from '@spartan-ng/ui-icon-helm';
import { HlmInputDirective } from '@spartan-ng/ui-input-helm';
import { HlmLabelDirective } from '@spartan-ng/ui-label-helm';
import { HlmPopoverContentDirective } from '@spartan-ng/ui-popover-helm';
import { HlmScrollAreaDirective } from '@spartan-ng/ui-scrollarea-helm';
import { HlmSeparatorDirective } from '@spartan-ng/ui-separator-helm';
import { HlmSwitchComponent } from '@spartan-ng/ui-switch-helm';
import { MarkdownComponent, provideMarkdown } from 'ngx-markdown';
import { AccordionPreviewComponent } from '../components/accordion/accordion.component';
import { SkeletonPreviewComponent } from '../components/skeleton-preview/skeleton-preview.component';
import { ChatService } from './chat-conversation.service';

const SAMPLE_PROMPT_1 = `I am an assistant in the faculty of Humanities and have a student with me here. Below is his request, what can I say to him:
I am a new doctoral student in the faculty of Humanities. I am looking forward to starting on my research. What are you able to assist with?
Please provide a detailed response that includes the following:
  •	An overview of the resources available to doctoral students in the faculty of Humanities
  •	Specific tools or platforms that can help with research planning and execution
  •	Any tips or best practices for managing a successful doctoral research project`;

const SAMPLE_PROMPT_2 = `I am a masters student and am looking for a research topic in the domain of Engineering. Please use your topic planning tools and internal resources to suggest a hot topic that is both innovative and feasible for a master's thesis. The topic should ideally:

  •	Address a current challenge in the field of Engineering
  •	Have sufficient resources and literature available for research

I'm aiming for a research that balances innovation and real-world applicability. A tool-informed, creative research topic would be amazing!`;

const SAMPLE_PROMPT_3 = `I need help coming up with research plan. Something in Medicine Cancer related and maybe after the year 2024. Please include some price guides.
  •	An overview of the current state of research in Cancer
  •	Recent advancements or breakthroughs in the field
  •	Specific areas of Cancer research that are currently underexplored or have potential for innovation
  •	Any relevant tools or platforms that can assist in planning and executing the research
  •	An estimated budget for conducting the research, including potential costs for resources, tools, and any other expenses that may arise`;

@Component({
  selector: 'app-chat-conversation',
  standalone: true,
  imports: [
    CommonModule,
    FormsModule,
    NgIcon,
    JsonPipe,
    AsyncPipe,
    HlmButtonDirective,
    HlmInputDirective,
    HlmFormFieldModule,
    HlmCardHeaderDirective,
    HlmCardContentDirective,
    HlmCardFooterDirective,
    HlmCardTitleDirective,
    HlmScrollAreaDirective,
    HlmIconDirective,
    HlmBadgeDirective,
    BrnPopoverComponent,
    BrnPopoverTriggerDirective,
    BrnPopoverContentDirective,
    HlmPopoverContentDirective,
    BrnAlertDialogTriggerDirective,
    BrnAlertDialogContentDirective,
    HlmAlertDialogComponent,
    HlmAlertDialogContentComponent,
    HlmAlertDialogHeaderComponent,
    HlmAlertDialogFooterComponent,
    HlmAlertDialogTitleDirective,
    HlmAlertDialogDescriptionDirective,
    HlmAlertDialogActionButtonDirective,
    HlmAlertDialogCancelButtonDirective,
    HlmAlertDirective,
    HlmAlertDescriptionDirective,
    HlmToasterComponent,
    HlmSeparatorDirective,
    BrnSeparatorComponent,
    HlmLabelDirective,
    HlmSwitchComponent,
    AccordionPreviewComponent,
    SkeletonPreviewComponent,
    MarkdownComponent,
  ],
  providers: [
    provideMarkdown(),
    provideIcons({
      lucideBrain,
      lucideBot,
      lucideSendHorizontal,
      lucideRefreshCw,
    }),
  ],
  templateUrl: './chat-conversation.component.html',
  styleUrl: './chat-conversation.component.css',
  changeDetection: ChangeDetectionStrategy.OnPush,
})
export class ChatConversationComponent implements OnInit {
  agents = signal<{}>({});
  eot = viewChild<ElementRef<HTMLElement>>('eot');
  agentMessages = viewChildren<ElementRef<HTMLElement>>('agentMessages');
  samplePrompts = [SAMPLE_PROMPT_1, SAMPLE_PROMPT_2, SAMPLE_PROMPT_3];

  constructor(public chatService: ChatService) {
    this.chatService.messagesStream.subscribe((messages) => {
      if (messages.length === 0) return;
      setTimeout(() => {
        this.scrollToBottom();
      }, 0);
    });
  }

  async ngOnInit() {
    this.resetChat();
    await this.chatService.fetchAvailableTools();
  }

  @HostListener('window:keyup.shift.enter', ['$event'])
  sendMessage(event: any) {
    event.preventDefault();
    this.chatService.sendMessage(event);
  }

  scrollToBottom() {
    this.eot()?.nativeElement.scrollIntoView({
      behavior: 'smooth',
    });
  }

  toggleTool() {}

  cancelReset(ctx: any) {
    ctx.close();
  }

  confirmReset(ctx: any) {
    ctx.close();
    this.resetChat();
  }

  private resetChat() {
    this.chatService.resetChat();
  }
}
